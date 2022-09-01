FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 5223
ENV ASPNETCORE_URLS=http://+:5223


FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY . .

FROM build AS publish
RUN dotnet publish "VisitBosnia" -c Release -o /app
FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ADD ./VisitBosnia/script.sql ./script.sql


ENTRYPOINT ["dotnet", "VisitBosnia.dll"]