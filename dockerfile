# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy all files
COPY . ./

# Restore and publish
RUN dotnet restore
RUN dotnet publish ./projectnet/projectnet.csproj -c Release -o /app/out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy from build stage
COPY --from=build /app/out .

# Open port 80
EXPOSE 80

# Run the app
ENTRYPOINT ["dotnet", "projectnet.dll"]
