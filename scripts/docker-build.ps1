Param()

$ImageName = "projeto-android-ci:latest"
Write-Host "Building Docker image $ImageName..."
docker build -t $ImageName .

Write-Host "Running container to build the project (mounting current directory)..."
$pwdEscaped = ${PWD}.Path
docker run --rm -v "${pwdEscaped}:/workspace" -w /workspace $ImageName

Write-Host "Container run completed. Check output above for build results."
