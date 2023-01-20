using Microsoft.AspNetCore.Mvc;

namespace ApiGateway.Controllers;

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