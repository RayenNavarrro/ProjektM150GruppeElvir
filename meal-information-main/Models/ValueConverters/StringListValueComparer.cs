using Microsoft.EntityFrameworkCore.ChangeTracking;

namespace MealInformation.Models.ValueConverters;

public class StringListValueComparer : ValueComparer<ICollection<string>>
{
    public StringListValueComparer() : base(
        (c1, c2) => c1.SequenceEqual(c2),
        c => c.Aggregate(0, (a, v) => HashCode.Combine(a, v.GetHashCode())),
        c => (ICollection<string>)c.ToList()
    )
    { }
}