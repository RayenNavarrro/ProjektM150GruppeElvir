using Microsoft.AspNetCore.Mvc;

namespace MealInformation.Controllers;

[ApiController]
[Route("[controller]")]
public class HealthController : Controller
{
    [HttpGet("readiness")]
    public IActionResult CheckReadiness()
    {
        return Ok();
    }
}