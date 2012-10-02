using System;
using CSharp.Crawlers.TypeResolvers;
using CSharp.Projects;
namespace CSharp.Crawlers
{
	public class EnumType : TypeBase<EnumType>, ICodeReference 
	{
        public bool AllTypesAreResolved { get; private set; }

		public string Type { get; private set; }
        public FileRef File { get; private set; }
		public string Signature { get { return string.Format("{0}.{1}", Namespace, Name); } }
		public string Namespace { get; private set; }
		public string Name { get; private set; }
        public string Scope { get; private set; }
		public int Line { get; private set; }
		public int Column { get; private set; }

        public EnumType(FileRef file, string ns, string name, string scope, int line, int column)
		{
            setThis(this);
			File = file;
			Namespace = ns;
			Name = name;
            Scope = scope;
			Line = line;
			Column = column;
		}

        public string GenerateFullSignature() {
            return null;
        }

        public void ResolveTypes(ICacheReader cache) {
            throw new NotImplementedException();
        }
	}
}

