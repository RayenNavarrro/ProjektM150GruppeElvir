using Microsoft.AspNetCore.Mvc;
using System.IO;
using System.Net;
using MealInformation.Models.Entities;

namespace MealInformation.Controllers;

public class CoffeCardController: Controller
{   
    public void GenerateQRCode()
    {
        var url = string.Format("http://chart.apis.google.com/chart?cht=qr&chs={1}x{2}&chl={0}", "https://github.com/RayenNavarrro/ProjektM150GruppeElvir", "100", "100");
        WebResponse response = default(WebResponse);
        Stream remoteStream = default(Stream);
        StreamReader readStream = default(StreamReader);
        WebRequest request = WebRequest.Create(url);
        response = request.GetResponse();
        remoteStream = response.GetResponseStream();
        readStream = new StreamReader(remoteStream);
        System.Drawing.Image img = System.Drawing.Image.FromStream(remoteStream);
        response.Close();
        remoteStream.Close();
        readStream.Close();
    }
}