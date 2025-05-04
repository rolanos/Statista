using AutoMapper;
using MediatR;
using Statista.Application.Common.Interfaces.Persistence;
using Statista.Application.Features.Files.Commands.CreateFile;
using Statista.Application.Features.Files.Dto;

namespace Statista.Application.Features.Forms.Commands.CreateForm;

public class CreateFileCommandHandler : IRequestHandler<CreateFileCommand, FileResponse>
{
    private readonly IFileRepository _fileRepository;
    private readonly IMapper _mapper;

    public CreateFileCommandHandler(IFileRepository fileRepository, IMapper mapper)
    {
        _fileRepository = fileRepository;
        _mapper = mapper;
    }

    //https://www.youtube.com/watch?v=6-FNejMrVuk
    public async Task<FileResponse> Handle(CreateFileCommand request, CancellationToken cancellationToken)
    {
        //ext
        List<string> validExtensions = new List<string>() { ".jpg", ".png" };
        string extension = Path.GetExtension(request.FormFile.FileName);
        if (!validExtensions.Contains(extension))
        {
            throw new Exception("Extension not valid");
        }
        //file size
        long size = request.FormFile.Length;
        if (size > (5 * 1024 * 1024))
        {
            throw new Exception("Max size should be 5 Mb");
        }
        //name
        var fileId = Guid.NewGuid();
        var fileName = fileId.ToString() + extension;
        var path = Path.Combine(Directory.GetCurrentDirectory(), "Uploads");
        using FileStream stream = new FileStream(Path.Combine(path, fileName), FileMode.Create);
        await request.FormFile.CopyToAsync(stream);
        var file = new Domain.Entities.File
        {
            Id = fileId,
            FullName = fileName,
            Size = size,
            ElementId = request.ElementId,
            CreatedDate = DateTime.UtcNow,
        };
        var createdFile = await _fileRepository.CreateFile(file);
        if (createdFile == null)
        {
            throw new Exception("File not created");
        }
        return _mapper.Map<FileResponse>(createdFile);
    }
}