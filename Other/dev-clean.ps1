
# Leeren des npm-Caches
Write-Host "Cleaning npm-Caches..."
npm cache clean --force

# Leeren des pip-Caches
Write-Host "Cleaning pip-Caches..."
pip cache purge

Write-Host "Cache-Cleaning done."
