public class EnumPosition
{
    public Guid Id { get; set; }
    public Guid ClassifierId { get; set; }
    public Classifier Classifier { get; set; }
    public string? Text { get; set; }
    public string? ImageLink { get; set; }
}