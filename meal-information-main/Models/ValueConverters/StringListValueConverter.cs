using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

namespace MealInformation.Models.ValueConverters;

public class StringListValueConverter : ValueConverter<ICollection<string>, string>
{
    private static string _delimiter = "|||";
    public StringListValueConverter() : base(
            list => string.Join(_delimiter, list),
            value => value.Split(_delimiter, System.StringSplitOptions.None).ToList()
        )
    { }
}