namespace Statista.Domain.Constants;

public static class QuestionType
{
    public const string Type = "Тип вопроса";
    public const string TypeGuid = "fdd1971e-82ab-40a5-ad25-32c64633d2d3";
    public const string SingleChoise = "Одиночный выбор";
    public const string MultipleChoice = "Множественный выбор";
    public const string Scale = "Шкала";
}

public static class QuestionTypeConstants
{
    public static Classifier QuestionTypeParent = new Classifier
    {
        Id = Guid.Parse(QuestionType.TypeGuid),
        Name = QuestionType.Type
    };
    public static Classifier SingleChoise = new Classifier
    {
        Id = Guid.Parse("2b517e05-2113-414b-80b6-628a7164f85b"),
        Name = QuestionType.SingleChoise,
        ParentId = Guid.Parse(QuestionType.TypeGuid)
    };
    public static Classifier MultipleChoice = new Classifier
    {
        Id = Guid.Parse("ee694d36-19f0-4cd2-a44f-19be00f31bdc"),
        Name = QuestionType.MultipleChoice,
        ParentId = Guid.Parse(QuestionType.TypeGuid),
    };
    public static Classifier Scale = new Classifier
    {
        Id = Guid.Parse("4ff1dcb2-04aa-4480-b7dc-3d1a91003572"),
        Name = QuestionType.Scale,
        ParentId = Guid.Parse(QuestionType.TypeGuid),
    };

    public static ICollection<Classifier> values = [
        QuestionTypeParent,
        SingleChoise,
        Scale,
        MultipleChoice,
    ];
}