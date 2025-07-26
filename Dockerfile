FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build
WORKDIR /app
COPY *.csproj .	
RUN dotnet restore
COPY . .
# Yayımlanmış çıktıları /app/publish_output dizinine kaydet
RUN dotnet publish AspNetCore_Docerize_Sample.csproj -c Release -o out
# Çalışma dizinini yayımlanmış çıktıların olduğu dizine ayarla

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
COPY --from=build /app/out .
ENV ASPNETCORE_URLS="http://*:4500"
ENV ASPNETCORE_ENVIRONMENT="Development"
ENTRYPOINT ["dotnet","AspNetCore_Docerize_Sample.dll"]