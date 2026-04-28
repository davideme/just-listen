var app = WebApplication.Create();
app.MapGet("/", () => Results.Ok());
app.Run("http://0.0.0.0:8080");
