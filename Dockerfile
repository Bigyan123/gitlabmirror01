# Define base image
FROM microsoft/dotnet:2.2-sdk AS build-env

# Copy project files
WORKDIR /source
COPY ["TestKSdkCore/TestKSdkCore.csproj", "./TestKSdkCore/TestKSdkCore.csproj"]

# Restore
RUN dotnet restore "TestKSdkCore/TestKSdkCore.csproj"

# Copy all source code
COPY . .

# Publish
WORKDIR /source/TestKSdkCore
RUN dotnet publish -c Release -o /publish

# Runtime
FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "TestKSdkCore.dll"]
