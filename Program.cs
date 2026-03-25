using Microsoft.EntityFrameworkCore;
using GestionStock.API.Data;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// SQLite
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlite("Data Source=gestionstock.db"));

// CORS pour Angular
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAngular", policy =>
        policy.WithOrigins(
            "http://localhost:4200",
            "https://gestion-stock-ui.vercel.app"
        )
        .AllowAnyHeader()
        .AllowAnyMethod());
});

var app = builder.Build();

// Créer la BDD automatiquement au démarrage
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    db.Database.Migrate();
}

// Swagger en dev ET en prod pour Railway
app.UseSwagger();
app.UseSwaggerUI();

app.UseCors("AllowAngular");
app.MapControllers();
app.Run();