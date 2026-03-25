FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY . .

# 🔥 Cherche directement le .csproj
RUN dotnet restore GestionStock.API/GestionStock.API.csproj
RUN dotnet publish GestionStock.API/GestionStock.API.csproj -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

COPY --from=build /app/out .

ENV ASPNETCORE_URLS=http://+:10000
EXPOSE 10000

ENTRYPOINT ["dotnet", "GestionStock.API.dll"]