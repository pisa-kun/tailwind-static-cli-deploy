npx tailwindcss -i ./src/input.css -o ./dist/output.css

aws s3 mb s3://tailwind-static-cli-deploy

aws s3api put-public-access-block --bucket tailwind-static-cli-deploy --public-access-block-configuration  "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

aws s3api put-bucket-policy --bucket tailwind-static-cli-deploy --policy file://policy/bucket-policy.json

aws s3 cp src/index.html s3://tailwind-static-cli-deploy/index.html
aws s3 cp dist/output.css s3://tailwind-static-cli-deploy/dist/output.css
aws s3 cp img/run_gopher.png s3://tailwind-static-cli-deploy/img/run_gopher.png

aws s3 website s3://tailwind-static-cli-deploy --index-document index.html
