using Statista.Domain.Entities;

namespace Statista.Domain.Constants;

public static class ReportTypeConstant
{
    public static ICollection<ReportType> values = new List<ReportType>() {
        new ReportType { Id = Guid.Parse("c3dde855-49e3-4e2a-abec-f2b9d9111cad"), Name = "Неясность формулировки"},
        new ReportType { Id = Guid.Parse("468f09da-aee5-49c9-b166-d8f6edc0a253"), Name = "Оскорбительность"},
        new ReportType { Id = Guid.Parse("afc4d748-ac28-486e-8914-5aaa36f7641b"), Name = "Дискриминация"},
        new ReportType { Id = Guid.Parse("9ae44721-f168-481d-a79f-fb63b424bfaa"), Name = "Предвзятость в формулировке"},
        new ReportType { Id = Guid.Parse("ac6961fa-5eae-47b3-bbd3-3b3099b88088"), Name = "Несоответствие тематике"},
        new ReportType { Id = Guid.Parse("73e49c14-2e8f-49e4-9c52-ae095a66c553"), Name = "Откровенный вопрос"},
    };
}