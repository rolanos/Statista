namespace Statista.Domain.Constants;

public static class QuestionType
{
    public const string Type = "Тип вопроса";
    public const string TypeGuid = "fdd1971e-82ab-40a5-ad25-32c64633d2d3";
    public const string SingleChoise = "Одиночный выбор";
    public const string MultipleChoice = "Множественный выбор";
    public const string Scale = "Шкала";
}

public static class RoleTypes
{
    public const string Type = "Тип роли";
    public const string TypeGuid = "7b50738a-9684-4395-919a-22903510f062";
    public const string SurveyAdmin = "Администратор";
    public const string SurveyEditor = "Редактор";
}

public static class RoleTypeConstants
{
    public static Classifier RoleTypeParent = new Classifier
    {
        Id = Guid.Parse(RoleTypes.TypeGuid),
        Name = RoleTypes.Type
    };
    public static Classifier SurveyAdmin = new Classifier
    {
        Id = Guid.Parse("007287a5-1b20-4348-9e1b-1f2fababd1ca"),
        Name = RoleTypes.SurveyAdmin,
        ParentId = Guid.Parse(RoleTypes.TypeGuid)
    };
    public static Classifier SurveyEditor = new Classifier
    {
        Id = Guid.Parse("86696706-5620-4a25-a2c8-60cac77abb26"),
        Name = RoleTypes.SurveyEditor,
        ParentId = Guid.Parse(RoleTypes.TypeGuid),
    };

    public static ICollection<Classifier> values = [
        RoleTypeParent,
        SurveyAdmin,
        SurveyEditor,
    ];
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