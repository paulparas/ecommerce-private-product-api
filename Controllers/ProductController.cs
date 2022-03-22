using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace private_microservice_1.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private static readonly List<Product> products = new()
        {
            new Product { Id = 1, Name = "PhoneXL", Description = "A large phone with one of the best screens", Price = 799 },
            new Product { Id = 2, Name = "Phone Mini", Price = 699, Description = "A great phone with one of the best cameras" },
            new Product { Id = 3, Name = "Phone Standard", Price = 299, Description = "" }
        };

        private readonly ILogger<ProductController> _logger;
        public ProductController(ILogger<ProductController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        [Route("GetProducts")]
        public IEnumerable<Product> GetProducts()
        {
            return products;
        }
    }
}
