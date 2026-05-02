FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /api

COPY *.sln ./
COPY Incidentapi-mounaa/*.csproj Incidentapi-mounaa/
COPY AppTests/*.csproj AppTests/

RUN dotnet restore

COPY . .

RUN dotnet publish Incidentapi-mounaa/Incidentapi-mounaa.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

ENV ASPNETCORE_URLS=http://0.0.0.0:80
EXPOSE 80

COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "Incidentapi-mounaa.dll"]