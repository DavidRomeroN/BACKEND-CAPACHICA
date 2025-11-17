@props(['url'])
<tr>
<td class="header">
<a href="{{ $url }}" style="display: inline-block;">
@php
    $appName = config('app.name', 'App');
    $logoUrl = env('APP_LOGO_URL');
@endphp
@if ($logoUrl)
    <img src="{{ $logoUrl }}" class="logo" alt="{{ $appName }} Logo" style="height: 75px; width: auto;">
@else
    <span style="font-size: 20px; font-weight: 700; color: #111827;">{{ $appName }}</span>
@endif
</a>
</td>
</tr>
