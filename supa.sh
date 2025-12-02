#!/bin/sh

# Source common functions
. ./functions.sh

printf '%s\n' "                                                                                              ";
printf '%s\n' "  /\$\$\$\$\$\$                                 /\$\$\$\$\$\$                            /\$\$          ";
printf '%s\n' " /\$\$__  \$\$                               /\$\$__  \$\$                          | \$\$          ";
printf '%s\n' "| \$\$  \\__/ /\$\$   /\$\$  /\$\$\$\$\$\$   /\$\$\$\$\$\$ | \$\$  \\__/  /\$\$\$\$\$\$   /\$\$\$\$\$\$   /\$\$\$\$\$\$\$  /\$\$\$\$\$\$\$";
printf '%s\n' "|  \$\$\$\$\$\$ | \$\$  | \$\$ /\$\$__  \$\$ |____  \$\$| \$\$       |____  \$\$ /\$\$__  \$\$ /\$\$__  \$\$ /\$\$_____/";
printf '%s\n' " \\____  \$\$| \$\$  | \$\$| \$\$  \\ \$\$  /\$\$\$\$\$\$\$| \$\$        /\$\$\$\$\$\$\$| \$\$  \\__/| \$\$  | \$\$|  \$\$\$\$\$\$ ";
printf '%s\n' " /\$\$  \\ \$\$| \$\$  | \$\$| \$\$  | \$\$ /\$\$__  \$\$| \$\$    \$\$ /\$\$__  \$\$| \$\$      | \$\$  | \$\$ \\____  \$\$";
printf '%s\n' "|  \$\$\$\$\$\$/|  \$\$\$\$\$\$/| \$\$\$\$\$\$\$/|  \$\$\$\$\$\$\$|  \$\$\$\$\$\$/|  \$\$\$\$\$\$\$| \$\$      |  \$\$\$\$\$\$\$ /\$\$\$\$\$\$\$/";
printf '%s\n' " \\______/  \\______/ | \$\$____/  \\_______/ \\______/  \\_______/|__/       \\_______/|_______/ ";
printf '%s\n' "                    | \$\$                                                                  ";
printf '%s\n' "                    | \$\$                                                                  ";
printf '%s\n' "                    |__/                                                                  ";
printf '%s\n' "                                                                                              ";

printf '%s\n' "An automated supabase self hosted setup script"

sleep 5

if ! docker info > /dev/null 2>&1; then
    printf "Docker no está corriendo o estas en modo rootless.\n"
    exit 1
fi

dots "Cloning the supabase repo"

git clone --filter=blob:none --no-checkout https://github.com/supabase/supabase
cd supabase
git sparse-checkout set --cone docker > /dev/null 2>&1 && git checkout master > /dev/null 2>&1
cd ..

dots "Making new supabase project directory"

mkdir supabase-project

printf '%s\n' "The tree of your project should look like this"

printf '%s\n' "├── supabase"
printf '%s\n' "└── supabase-project"

sleep 5

dots "Copying the compose files over to your project"

cp -rf supabase/docker/* supabase-project

dots "Copying the fake .env files"

cp supabase/docker/.env.example supabase-project/.env

dots "Switching to your project directory"

cd supabase-project

dots "Pulling the latest supabase image"

docker compose pull 

dots "Starting supabase services"

docker compose up -d 

printf '%s\n' "Showing the status of your supabase services"

docker compose ps

printf '%s\n' "You can access the supabase studio at http://localhost:8000"
printf '%s\n' "Your username is: supabase"
printf '%s\n' "Your password is: this_password_is_insecure_and_should_be_updated"
printf '%s\n' "Read the docs to change the password"
printf '%s\n' "https://supabase.com/docs/guides/self-hosting/docker#dashboard-authentication"
printf '%s\n' "Your supabase self hosted setup is complete!"