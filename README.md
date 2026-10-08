# docker-dotnet-core-telerik-reporting

> **Retired in October 2026.** This image last built in February 2021, on .NET Core 2.2, which reached end of life in December 2019. Build on `mcr.microsoft.com/dotnet/aspnet` with a supported .NET release instead. Current WhatIsHeDoing images live in [WhatIsHeDoing/containers](https://github.com/WhatIsHeDoing/containers).

[![.NET Core Telerik Reporting Base pulls](https://img.shields.io/docker/pulls/whatishedoing/dotnet-core-telerik-reporting-base.svg)][site]
[![.NET Core Telerik Reporting Base build](https://img.shields.io/docker/cloud/build/whatishedoing/dotnet-core-telerik-reporting-base.svg)][site]

## 👋 Introduction

[Telerik Reporting] has been ported to [.NET Core]. However, containerising it is surprisingly challenging!

To alleviate some of the major problems, this base [Docker] image should allow you to run your compiled
reporting project, as part of a multi-stage image.

## 🏃‍ Usage

```dockerfile
# https://docs.microsoft.com/en-gb/aspnet/core/host-and-deploy/docker/building-net-docker-images
# https://docs.telerik.com/reporting/use-reports-in-net-core-apps
# https://feedback.telerik.com/reporting/1406043-can-not-run-in-docker

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build

WORKDIR /build
COPY . ./

RUN dotnet restore
RUN dotnet build --configuration Release --output dist

FROM build AS publish
RUN dotnet publish --configuration Release --output dist

FROM whatishedoing/dotnet-core-telerik-reporting-base:latest AS base

EXPOSE 80

WORKDIR /app
COPY --from=publish /build/dist .

ENTRYPOINT ["dotnet", "report-service.dll"]
```

[docker]: https://www.docker.com/
[site]: https://hub.docker.com/r/whatishedoing/dotnet-core-telerik-reporting-base
[telerik reporting]: https://www.telerik.com/products/reporting
