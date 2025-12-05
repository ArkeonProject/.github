ORG="ArkeonProject"

for repo in $(gh repo list $ORG --json name -q '.[].name'); do
  echo "Checking develop in $repo..."

  if ! gh api "/repos/$ORG/$repo/branches/develop" >/dev/null 2>&1; then
    echo "→ Creating develop branch in $repo"
    gh api \
      -X POST \
      "/repos/$ORG/$repo/git/refs" \
      -f ref="refs/heads/develop" \
      -f sha=$(gh api /repos/$ORG/$repo/git/refs/heads/main --jq '.object.sha')
  fi
done
