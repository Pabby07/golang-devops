run:
    @echo ":::: App is startin up ::::"
    @echo "CONFIG:: Exporting environemnt variables"

    /bin/sh .env
    @echo "SUCCESS:  ✔ Environment variables exported"
    @echo "INIT::::  ⚡ Running server"
    ./build.sh