<?php

namespace App\Controller;

use App\Services\HttpService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api', name: 'app_api_')]
class ApiController extends AbstractController
{
    #[Route('/health-check', name: 'health_check')]
    public function healthCheck(): Response
    {
        return new Response('', 204);
    }
    
    #[Route('/static', name: 'static')]
    public function static(): JsonResponse
    {
        return $this->json([
            'status' => true,
        ]);
    }

    #[Route('/http-request', name: 'http_request')]
    public function httpRequest(HttpService $httpService): JsonResponse
    {
        return $this->json(json_decode($httpService->get('http://whoami/api')));
    }
}
