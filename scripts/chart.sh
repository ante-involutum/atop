helm dependency update charts
helm package charts
mv atop-*.tgz ../chartrepo 
cd ../chartrepo
helm repo index --url  https://no8ge.github.io/chartrepo/ .
git add .
git commit -m 'updata atop'
git push
rm atop-*.tgz