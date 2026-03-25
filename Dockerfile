FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copier tout
COPY . .

# 🔥 Aller dans le BON dossier (corrigé)
WORKDIR /app/GestionStock.API/GestionStock.API

RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/GestionStock.API/GestionStock.API/out .

ENV ASPNETCORE_URLS=http://+:10000
EXPOSE 10000

ENTRYPOINT ["dotnet", "GestionStock.API.dll"]