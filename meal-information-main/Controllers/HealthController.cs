using Microsoft.AspNetCore.Mvc;
using MealInformation.Controllers;

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