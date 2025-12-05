ORG="ArkeonProject"

for repo in $(gh repo list $ORG --json name -q '.[].name'); do
  echo "Configuring MAIN for $repo"

  gh api \
    -X PUT \
    "/repos/$ORG/$repo/branches/main/protection" \
    -H "Accept: application/vnd.github+json" \
    -F required_pull_request_reviews.dismiss_stale_reviews=true \
    -F required_pull_request_reviews.require_code_owner_reviews=false \
    -F required_pull_request_reviews.required_approving_review_count=1 \
    -F required_status_checks.strict=true \
    -F required_status_checks.contexts[]="ci" \
    -F enforce_admins=true \
    -F required_linear_history=true \
    -F allow_force_pushes=false \
    -F allow_deletions=false
done
