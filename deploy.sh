#!/bin/bash

#!/bin/bash

set -e

echo "🔁 Switching to main branch..."
git checkout main

echo "🧼 Cleaning old build..."
rm -rf public

echo "🏗️  Building site with Hugo..."
hugo -d public

echo "📦 Copying build to temp..."
rm -rf /tmp/hugo-deploy
cp -r public /tmp/hugo-deploy

echo "🌱 Switching to gh-pages branch..."
git checkout gh-pages

echo "🔥 Clearing old gh-pages contents..."
git rm -rf .

# exclude theme from deploy
rsync -av --progress /tmp/hugo-deploy/ . --exclude themes

echo "✅ Committing changes..."
git add .
git commit -m "🚀 deploy site"

echo "📡 Pushing to GitHub..."
git push origin gh-pages

echo "🎉 Deployed! Check your site at:"
echo "https://joshalvarado99.github.io/trystero/"
