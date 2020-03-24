FROM mcr.microsoft.com/dotnet/core/sdk AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY web-app-demo/*.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY ./web-app-demo ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "web-app-demo.dll"]