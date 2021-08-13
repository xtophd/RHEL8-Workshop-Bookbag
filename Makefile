default:
	find ./workshop/content/ -type f -exec sed -i "s/%USERNAME%/Makefile-User/g" {} \;
	find ./workshop/content/ -type f -exec sed -i "s/%PASSWORD%/<PASSWORD>/g" {} \;
	find ./workshop/content/ -type f -exec sed -i "s/%IP_ADDRESS%/<IP_ADDRESS>/g" {} \;
	asciidoctor -v workshop/content/index.adoc -D public -a gitlab_hosted=true
