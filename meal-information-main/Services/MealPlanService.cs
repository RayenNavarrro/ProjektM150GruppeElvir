using System.ServiceModel.Syndication;
using System.Text.RegularExpressions;
using System.Xml;
using HtmlAgilityPack;
using MealInformation.Models.Entities;

namespace MealInformation.Services
{
    public class MealPlanService
    {
        // TODO: Put feed uri in configuration
        private const string FEED_URI = "https://zfv.ch/de/menus/rssMenuPlan?menuId=260&type=uzh2&dayOfWeek=";
        public List<Menu> FetchMenuesForDayOfWeek(int dayOfWeek)
        {
            var uri = FEED_URI + dayOfWeek;
            XmlReader reader = new CustomXmlReader(uri);
            var feed = SyndicationFeed.Load(reader);

            var post = feed.Items.FirstOrDefault();

            var menus = new List<Menu>();

            if (post != null)
            {

                var htmlDocument = new HtmlDocument();
                htmlDocument.LoadHtml(post.Summary.Text);

                var menuTitleNotes = htmlDocument.DocumentNode.SelectNodes("/div/h3");
                if (menuTitleNotes == null)
                {
                    return menus;
                }

                foreach (var menuTitleNode in menuTitleNotes)
                {
                    var menu = new Menu();

                    // Title
                    menu.Title = menuTitleNode.InnerText.Trim().Split('|')[0].Trim();

                    // Price
                    string pricePattern = @"\d+(?:[.,]\d{0,2})?";
                    Regex priceRegex = new Regex(pricePattern);

                    var priceNode = menuTitleNode.SelectSingleNode("child::span[@class=\"price\"]");
                    string? priceText = priceNode?.InnerText;

                    if (!string.IsNullOrEmpty(priceText))
                    {
                        string[] priceAndEmtpy = priceText.Split('|');
                        if (priceAndEmtpy.Length == 2)
                        {
                            string[] prices = priceAndEmtpy[1].Split('/');
                            if (prices.Length == 2)
                            {
                                prices = prices.Select(price => priceRegex.Match(price).Value).ToArray();
                                if (decimal.TryParse(prices[0], out decimal priceInternal))
                                {
                                    menu.PriceInternal = priceInternal;
                                }
                                if (decimal.TryParse(prices[1], out decimal priceExternal))
                                {
                                    menu.PriceExternal = priceExternal;
                                }
                            }
                        }
                    }

                    if (!string.IsNullOrEmpty(priceText))
                    {
                        string[] priceAndEmtpy = priceText.Split('|');
                        if (priceAndEmtpy.Length == 2)
                        {
                            string[] prices = priceText.Split('/');
                            if (prices.Length == 2)
                            {

                            }
                        }
                    }

                    // Description
                    var menuComponentsNode = menuTitleNode.SelectSingleNode("following-sibling::p[1]");
                    menu.MenuComponents = menuComponentsNode?.InnerText?.Trim()
                                                                        .Split("\n", StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
                                                                        .ToList() ?? new List<string>();

                    // NutritionalValues
                    var nutritionalValuesNode = menuTitleNode.SelectSingleNode("following-sibling::table[1]");

                    if (nutritionalValuesNode != null)
                    {
                        menu.NutritionalValues = GetNutritionalValues(nutritionalValuesNode);
                    }

                    // Gets Balance and EnvironmentalImpact, doesn't work if they are mixed up :/
                    var additionalInformationsNode = menuTitleNode.SelectSingleNode("following-sibling::table[2]");
                    if (additionalInformationsNode != null)
                    {
                        var additionalInformationNodeRows = additionalInformationsNode.SelectNodes("tr");
                        menu.Balance = additionalInformationNodeRows[0].SelectNodes("td")[1].InnerText.Trim();
                        menu.EnvironmentalImpact = additionalInformationNodeRows[1].SelectNodes("td")[1].InnerText.Trim();
                    }

                    // Allergens
                    var allergenesNode = menuTitleNode.SelectSingleNode("following-sibling::p[2]");
                    menu.Allergenes = allergenesNode?.InnerHtml?.Substring(':')
                                                                .Trim()
                                                                .Split(",", StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
                                                                .ToList<string>() ?? new List<string>();

                    // Icons
                    var iconNodes = menuTitleNode.SelectSingleNode("following-sibling::img");
                    if (iconNodes != null)
                    {
                        menu.Icons = GetIcons(iconNodes);
                    }

                    menus.Add(menu);
                }


                reader.Close();
            }

            return menus;
        }

        private List<NutritionalValue> GetNutritionalValues(HtmlNode nutritionalValuesNode)
        {
            var list = new List<NutritionalValue>();
            int rowIndex = 0;
            var rows = nutritionalValuesNode.SelectNodes("tr");
            if (rows == null)
            {
                return list;
            }

            foreach (var nutritionalValueNode in rows)
            {
                var nutritionalValue = new NutritionalValue();
                var columns = nutritionalValueNode.SelectNodes("td");
                if (columns == null)
                {
                    continue;
                }

                nutritionalValue.Title = columns[0].InnerText.Trim();
                nutritionalValue.Value = columns[1].InnerText.Trim();
                nutritionalValue.RowIndex = rowIndex;

                list.Add(nutritionalValue);

                rowIndex++;
            }

            return list;
        }

        // Gets all img Nodes until a br tag
        private List<Icon> GetIcons(HtmlNode firstIconNode)
        {
            var list = new List<Icon>();
            var currentNode = firstIconNode;

            while (currentNode.Name != "br")
            {
                if (currentNode.Name == "img")
                {
                    var icon = new Icon();
                    icon.AltText = currentNode.GetAttributeValue("alt", "");
                    icon.SourceUri = currentNode.GetAttributeValue("src", "");
                    list.Add(icon);
                }

                currentNode = currentNode.NextSibling;
            }
            return list;
        }
    }
}