#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
#Dockerfile

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["private-microservice-1.csproj", "."]
RUN dotnet restore "./private-microservice-1.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "private-microservice-1.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "private-microservice-1.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "private-microservice-1.dll"]
