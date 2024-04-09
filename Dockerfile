# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /source

COPY . .
RUN dotnet restore "./weathertestapi/weathertestapi.csproj"
RUN dotnet publish "./weathertestapi/weathertestapi.csproj" -c release -o /app --no-restore

# Serve Stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
ENV ASPNETCORE_ENVIRONMENT=Development
EXPOSE 80
COPY --from=build /app ./
ENTRYPOINT [ "dotnet", "weathertestapi.dll" ]