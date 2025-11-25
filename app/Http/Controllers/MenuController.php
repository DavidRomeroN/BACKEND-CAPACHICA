<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class MenuController extends Controller
{
    /**
     * Obtiene el menú dinámico basado en los permisos del usuario autenticado
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getMenu(Request $request)
    {
        // Obtener el usuario actual
        $user = Auth::user();
        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized',
                'data' => []
            ], 401);
        }
        
        // Obtener todos los permisos del usuario (incluyendo los heredados a través de roles)
        $permissions = $user->getAllPermissions()->pluck('name')->toArray();
        
        // Verificar si el usuario es admin - MÚLTIPLES FORMAS DE VERIFICAR
        $isAdmin = $user->hasRole('admin');
        $userRoles = $user->getRoleNames()->toArray();
        $isAdminAlt = in_array('admin', $userRoles);
        
        // Log para debug
        \Log::info('Verificación de Admin', [
            'user_id' => $user->id,
            'user_email' => $user->email,
            'hasRole_admin' => $isAdmin,
            'in_array_admin' => $isAdminAlt,
            'user_roles' => $userRoles,
            'all_roles' => $user->roles->pluck('name')->toArray()
        ]);
        
        // Usar ambas verificaciones para estar seguro
        $isAdmin = $isAdmin || $isAdminAlt;
        
        // Verificar si el usuario administra emprendimientos
        $administraEmprendimientos = $user->administraEmprendimientos();
        
        // Definir la estructura del menú completo
        $fullMenu = $this->getFullMenuStructure($administraEmprendimientos);
        
        // Filtrar el menú según los permisos del usuario y rol admin
        $filteredMenu = $this->filterMenuByPermissions($fullMenu, $permissions, $isAdmin);
        
        // SI ES ADMIN, AGREGAR APROBACIONES DIRECTAMENTE (por si acaso no se agregó)
        if ($isAdmin) {
            $hasApprovals = false;
            foreach ($filteredMenu as $item) {
                if (isset($item['id']) && $item['id'] === 'approvals') {
                    $hasApprovals = true;
                    break;
                }
            }
            
            // Si no está, agregarlo manualmente
            if (!$hasApprovals) {
                $approvalsItem = [
                    'id' => 'approvals',
                    'title' => 'Aprobaciones Pendientes',
                    'icon' => 'notification',
                    'path' => '/admin/approvals'
                ];
                
                // Insertarlo después de "planes" y antes de "profile"
                $insertIndex = -1;
                foreach ($filteredMenu as $index => $item) {
                    if (isset($item['id']) && $item['id'] === 'planes') {
                        $insertIndex = $index + 1;
                        break;
                    }
                    if (isset($item['id']) && $item['id'] === 'profile') {
                        $insertIndex = $index;
                        break;
                    }
                }
                
                if ($insertIndex >= 0) {
                    array_splice($filteredMenu, $insertIndex, 0, [$approvalsItem]);
                } else {
                    // Si no encontramos dónde insertarlo, agregarlo al final antes de profile
                    $filteredMenu[] = $approvalsItem;
                }
            }
        }
        
        // Debug detallado
        $approvalsItem = null;
        foreach ($filteredMenu as $item) {
            if (isset($item['id']) && $item['id'] === 'approvals') {
                $approvalsItem = $item;
                break;
            }
        }
        
        \Log::info('Menu Debug FINAL', [
            'user_id' => $user->id,
            'user_email' => $user->email,
            'is_admin' => $isAdmin,
            'user_roles' => $userRoles,
            'full_menu_count' => count($fullMenu),
            'filtered_menu_count' => count($filteredMenu),
            'approvals_in_filtered' => $approvalsItem !== null,
            'approvals_item' => $approvalsItem,
            'filtered_menu_ids' => array_column($filteredMenu, 'id'),
            'filtered_menu_titles' => array_column($filteredMenu, 'title')
        ]);
        
        // LOG CRÍTICO: Verificar que approvals esté en la respuesta final
        $finalHasApprovals = false;
        foreach ($filteredMenu as $item) {
            if (isset($item['id']) && $item['id'] === 'approvals') {
                $finalHasApprovals = true;
                \Log::warning('✅ APROBACIONES ENCONTRADO EN MENÚ FINAL', ['item' => $item]);
                break;
            }
        }
        
        if (!$finalHasApprovals && $isAdmin) {
            \Log::error('❌ ERROR CRÍTICO: Admin detectado pero approvals NO está en el menú final', [
                'filtered_menu' => $filteredMenu
            ]);
        }
        
        return response()->json([
            'success' => true,
            'data' => $filteredMenu,
            'debug' => [
                'is_admin' => $isAdmin,
                'has_approvals' => $finalHasApprovals,
                'menu_count' => count($filteredMenu)
            ]
        ]);
    }
    
    /**
     * Define la estructura completa del menú
     *
     * @param bool $incluyeMenuEmprendedor Si es true, incluye opciones específicas para emprendedores
     * @return array
     */
    private function getFullMenuStructure($incluyeMenuEmprendedor = false)
    {
        $menu = [
            [
                'id' => 'dashboard',
                'title' => 'Dashboard',
                'icon' => 'dashboard',
                'path' => '/dashboard',
                'permissions' => ['user_read'], // Permisos mínimos para ver el dashboard
            ],
            [
                'id' => 'users',
                'title' => 'Usuarios',
                'icon' => 'users',
                'path' => '/admin/users',
                'permissions' => ['user_create'],
                'children' => [
                    [
                        'id' => 'user-list',
                        'title' => 'Gestión de Usuarios',
                        'path' => '/admin/users',
                        'permissions' => ['user_read'],
                    ],
                    [
                        'id' => 'roles',
                        'title' => 'Roles',
                        'path' => '/admin/roles',
                        'permissions' => ['role_read'],
                    ],
                    [
                        'id' => 'permissions',
                        'title' => 'Permisos',
                        'path' => '/admin/permissions',
                        'permissions' => ['permission_read'],
                    ],
                ]
            ],
            [
                'id' => 'municipalidad',
                'title' => 'Municipalidad',
                'icon' => 'building',
                'path' => '/admin/municipalidad',
                'permissions' => ['municipalidad_update'],
            ],
            [
                'id' => 'evento',
                'title' => 'Evento',
                'icon' => 'events',
                'path' => '/admin/evento',
                'permissions' => ['user_create'],
            ],
            [
                'id' => 'emprendedores',
                'title' => 'Emprendedores',
                'icon' => 'store',
                'path' => '/admin/emprendedores',
                'permissions' => ['emprendedor_create'],
                'children' => [
                    [
                        'id' => 'emprendedor-list',
                        'title' => 'Gestión de Emprendedores',
                        'path' => '/admin/emprendedores',
                        'permissions' => ['emprendedor_read'],
                    ],
                    [
                        'id' => 'asociacion-list',
                        'title' => 'Gestión de Asociaciones',
                        'path' => '/admin/asociaciones',
                        'permissions' => ['asociacion_read'],
                    ],
                ]
            ],
            [
                'id' => 'servicios',
                'title' => 'Servicios',
                'icon' => 'briefcase',
                'path' => '/admin/servicios',
                'permissions' => ['servicio_create'],
                'children' => [
                    [
                        'id' => 'servicio-list',
                        'title' => 'Gestión de Servicios',
                        'path' => '/admin/servicios',
                        'permissions' => ['servicio_read'],
                    ],
                    [
                        'id' => 'categorias',
                        'title' => 'Categorías',
                        'path' => '/admin/categorias',
                        'permissions' => ['categoria_read'],
                    ],
                ]
            ],
            [
                'id' => 'reservas',
                'title' => 'Reservas',
                'icon' => 'calendar',
                'path' => '/admin/reservas',
                'permissions' => ['user_read'], // Asumiendo que cualquier usuario puede ver reservas
                'children' => [
                    [
                        'id' => 'reserva-list',
                        'title' => 'Gestion de Reservas',
                        'path' => '/admin/reservas',
                        'permissions' => ['reserva_update'],
                    ],
                    [
                        'id' => 'mis-reservas',
                        'title' => 'Mis Reservas',
                        'path' => '/admin/reservas/mis-reservas',
                        'permissions' => ['user_read'],
                    ],
                    [
                        'id' => 'mis-inscripciones',
                        'title' => 'Mis Inscripciones',
                        'path' => '/admin/reservas/mis-inscripciones',
                        'permissions' => ['user_read'],
                    ], 
                ]
            ],
            [
                'id' => 'planes',
                'title' => 'Gestionar planes',
                'icon' => 'chart',
                'path' => '/admin/planes',
                'permissions' => ['plan_update'], 
            ],
            [
                'id' => 'approvals',
                'title' => 'Aprobaciones Pendientes',
                'icon' => 'notification',
                'path' => '/admin/approvals',
                'permissions' => ['admin_only'], // Solo para administradores
            ],
            [
                'id' => 'profile',
                'title' => 'Mi Perfil',
                'icon' => 'user',
                'path' => '/admin/profile',
                'permissions' => ['user_read'], // Todos los usuarios pueden ver su perfil
            ],
            
        ];
        
    
        
        return $menu;
    }
    
    /**
     * Filtra el menú según los permisos del usuario
     *
     * @param array $menu
     * @param array $userPermissions
     * @param bool $isAdmin
     * @return array
     */
    private function filterMenuByPermissions($menu, $userPermissions, $isAdmin = false)
    {
        $filteredMenu = [];
        
        foreach ($menu as $item) {
            // Verificar si el ítem requiere ser admin
            $requiresAdmin = in_array('admin_only', $item['permissions']);
            
            // Si requiere admin y el usuario NO es admin, saltar este ítem
            if ($requiresAdmin && !$isAdmin) {
                continue;
            }
            
            // Si requiere admin y el usuario ES admin, incluir directamente
            if ($requiresAdmin && $isAdmin) {
                $menuItem = [
                    'id' => $item['id'],
                    'title' => $item['title'],
                    'icon' => $item['icon'],
                    'path' => $item['path'],
                ];
                
                // Si tiene hijos, filtrarlos también
                if (isset($item['children']) && !empty($item['children'])) {
                    $filteredChildren = [];
                    
                    foreach ($item['children'] as $child) {
                        $hasChildPermission = count(array_intersect($child['permissions'], $userPermissions)) > 0;
                        
                        if ($hasChildPermission) {
                            $filteredChildren[] = [
                                'id' => $child['id'],
                                'title' => $child['title'],
                                'path' => $child['path'],
                            ];
                        }
                    }
                    
                    if (!empty($filteredChildren)) {
                        $menuItem['children'] = $filteredChildren;
                    }
                }
                
                $filteredMenu[] = $menuItem;
                continue;
            }
            
            // Para ítems que NO requieren admin, verificar permisos normales
            // Excluir 'admin_only' de la verificación de permisos
            $permissionsToCheck = array_filter($item['permissions'], function($perm) {
                return $perm !== 'admin_only';
            });
            
            $hasPermission = empty($permissionsToCheck) || count(array_intersect($permissionsToCheck, $userPermissions)) > 0;
            
            // Si tiene permiso, procesar este ítem del menú
            if ($hasPermission) {
                $menuItem = [
                    'id' => $item['id'],
                    'title' => $item['title'],
                    'icon' => $item['icon'],
                    'path' => $item['path'],
                ];
                
                // Si tiene hijos, filtrarlos también
                if (isset($item['children']) && !empty($item['children'])) {
                    $filteredChildren = [];
                    
                    foreach ($item['children'] as $child) {
                        $hasChildPermission = count(array_intersect($child['permissions'], $userPermissions)) > 0;
                        
                        if ($hasChildPermission) {
                            $filteredChildren[] = [
                                'id' => $child['id'],
                                'title' => $child['title'],
                                'path' => $child['path'],
                            ];
                        }
                    }
                    
                    // Solo añadir children si hay elementos
                    if (!empty($filteredChildren)) {
                        $menuItem['children'] = $filteredChildren;
                    }
                }
                
                $filteredMenu[] = $menuItem;
            }
        }
        
        return $filteredMenu;
    }
}