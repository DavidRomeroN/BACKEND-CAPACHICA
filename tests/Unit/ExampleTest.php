<?php

namespace Tests\Unit;

use Tests\TestCase;

class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     */
    public function test_that_true_is_true(): void
    {
        $this->assertTrue(true);
    }
    
    /**
     * Test basic application is created
     */
    public function test_application_returns_successful_response(): void
    {
        $response = $this->get('/');
        $response->assertStatus(200);
    }
}
