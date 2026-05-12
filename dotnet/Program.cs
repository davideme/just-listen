var builder = WebApplication.CreateSlimBuilder();
var app = builder.Build();
app.MapGet("/", () => Results.Ok());
app.Run("http://0.0.0.0:8080");
