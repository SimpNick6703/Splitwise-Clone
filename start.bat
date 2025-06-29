@echo off
echo INFO: Starting Splitwise Clone Application...
echo.

REM Check if Docker is running
docker info >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ERROR: Docker is not running. Please start Docker first.
    exit /b 1
)

REM Check if Docker Compose is available
docker-compose --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ERROR: Docker Compose is not installed. Please install Docker Compose first.
    exit /b 1
)

echo INFO: Docker is running
echo INFO: Docker Compose is available
echo.

echo INFO: Building and starting services...
docker-compose up --build -d

echo.
echo INFO: Waiting for services to be ready...
timeout /t 10 /nobreak >nul

echo.
echo INFO: Application is ready!
echo.
echo - Frontend: http://localhost:3000
echo - Backend API: http://localhost:8000
echo - API Documentation: http://localhost:8000/docs
echo.
echo To stop the application, run: docker-compose down
echo To view logs, run: docker-compose logs -f
