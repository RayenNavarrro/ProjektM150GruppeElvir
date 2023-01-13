using System.Globalization;
using System.Text.RegularExpressions;
using System.Xml;

namespace MealInformation.Services
{
    public class CustomXmlReader : XmlTextReader
    {
        private bool _readingDate = false;

        private const string TimeZonePattern = @"(?![0-9])(CE[S]?T)(?=[0-9])";

        private const string CustomDateTimeFormat = "yyyy-MM-dd HH:mm:sszzz";

        public CustomXmlReader(Stream s) : base(s)
        {
        }

        public CustomXmlReader(string inputUri) : base(inputUri)
        {
        }

        public override void ReadStartElement()
        {
            if (string.Equals(base.LocalName, "Updated", StringComparison.InvariantCultureIgnoreCase) ||
                string.Equals(base.LocalName, "Published", StringComparison.InvariantCultureIgnoreCase))
            {
                _readingDate = true;
            }

            base.ReadStartElement();
        }

        public override void ReadEndElement()
        {
            if (_readingDate)
            {
                _readingDate = false;
            }

            base.ReadEndElement();
        }

        public override string ReadString()
        {
            if (!_readingDate) return base.ReadString();

            var dateString = base.ReadString();
            DateTime dt;
            if (!DateTime.TryParse(dateString, out dt))
            {
                dateString = Regex.Replace(dateString, TimeZonePattern, " ");
                dt = DateTime.ParseExact(dateString, CustomDateTimeFormat, CultureInfo.InvariantCulture);
            }

            var output = dt.ToUniversalTime().ToString("O", CultureInfo.InvariantCulture);
            return output;
        }
    }
}