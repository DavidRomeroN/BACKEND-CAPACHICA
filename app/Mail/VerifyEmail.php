<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Config;

class VerifyEmail extends Mailable implements ShouldQueue
{
    use Queueable, SerializesModels;

    public $user;
    public $verificationUrl;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($user)
    {
        $this->user = $user;
        
        // Crear URL de verificación personalizada para la API
        $this->verificationUrl = $this->verificationUrl($user);
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->subject('Verificación de correo electrónico')
                    ->markdown('emails.verify-email');
    }
    
    /**
     * Get the verification URL for the given user.
     *
     * @param  mixed  $user
     * @return string
     */
    protected function verificationUrl($user)
    {
        // Generar URL firmada temporalmente hacia la ruta de la API
        $signedApiUrl = URL::temporarySignedRoute(
            'verification.verify',
            Carbon::now()->addMinutes(Config::get('auth.verification.expire', 60)),
            [
                'id' => $user->getKey(),
                'hash' => sha1($user->getEmailForVerification()),
            ],
            true
        );
        
        // Generar URL web firmada directa (recomendada) para navegadores/email
        return URL::temporarySignedRoute(
            'verification.verify.web.direct',
            Carbon::now()->addMinutes(Config::get('auth.verification.expire', 60)),
            [
                'id' => $user->getKey(),
                'hash' => sha1($user->getEmailForVerification()),
            ],
            true
        );
    }
}