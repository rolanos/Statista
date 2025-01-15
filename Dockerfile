# Используем официальный образ .NET SDK для сборки приложения
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /src

# Убрать на релизе, нужно для отображения swagger
# ENV ASPNETCORE_ENVIRONMENT=Development

# Копируем все файлы и папки проекта
COPY . ./

# Переходим в директорию с проектом Statista.Api
WORKDIR /src/Statista.Api

# Восстанавливаем зависимости для всех проектов
RUN dotnet restore

# Собираем проект
RUN dotnet publish -c Release -o /app

# Создаем минимальный образ для выполнения приложения
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app .

# Открываем порт 80 для входящих HTTP-запросов
EXPOSE 8080

# Устанавливаем команду для запуска приложения
ENTRYPOINT ["dotnet", "Statista.Api.dll"]
