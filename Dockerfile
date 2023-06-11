#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
#Dockerfile

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
#EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["ecommerce-private-product-api.csproj", "."]
RUN dotnet restore "./ecommerce-private-product-api.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "ecommerce-private-product-api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ecommerce-private-product-api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ecommerce-private-product-api.dll"]
