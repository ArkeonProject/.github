ORG="ArkeonProject"

for repo in $(gh repo list $ORG --json name -q '.[].name'); do
  echo "Configuring DEVELOP for $repo"

  gh api \
    -X PUT \
    "/repos/$ORG/$repo/branches/develop/protection" \
    -H "Accept: application/vnd.github+json" \
    -F required_pull_request_reviews.dismiss_stale_reviews=false \
    -F required_pull_request_reviews.required_approving_review_count=0 \
    -F required_status_checks.strict=false \
    -F required_status_checks.contexts[]="" \
    -F enforce_admins=false \
    -F required_linear_history=false \
    -F allow_force_pushes=false \
    -F allow_deletions=false
done
