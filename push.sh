# deploy -> /check/dist/docs (WebUI should not define docs page/route)
# tar: ./docs/os-checker/os-checker-test-suite/.lock: Cannot open: Permission denied
find deploy -type f -name ".lock" -delete
mv deploy dist/docs

git config --global user.name $GIT_AUTHOR
git config --global user.email $GIT_EMAIL
git config --global committer.name $GIT_AUTHOR
git config --global committer.email $GIT_EMAIL

echo "正在 clone" $DATABASE_REPO
gh repo clone $DATABASE_REPO $DATABASE_REPO
gh auth setup-git
echo "成功 clone" $DATABASE_REPO

# clean ui
rm $DATABASE_REPO/ui -rf

# ui -> $DATABASE_REPO/ui
mv ui $DATABASE_REPO

# clean old plugin dir
rm $DATABASE_REPO/plugin -rf

# cargo -> $DATABASE_REPO/plugin/cargo/info
mkdir -p $DATABASE_REPO/plugin/cargo
mv cargo $DATABASE_REPO/plugin/cargo/info

# github-api -> $DATABASE_REPO/plugin/github-api
mv github-api $DATABASE_REPO/plugin

# commit & push changes
cd $DATABASE_REPO
echo "update plugin folder for" $DATABASE_REPO
export branch=$(git branch --show-current)

git status
git add .
echo "正在提交：$(git status --porcelain)"
git commit -m "[bot] update plugin dir from os-checker-plugin-github-api repo"
echo "提交成功，正在推送到 database 仓库（分支：$branch）"
git push
echo "成功推送到 database 仓库（分支：$branch）"
