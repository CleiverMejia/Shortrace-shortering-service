import { ShortUrl } from "../../domain/entities/short-url";
import { ShortCodeGenerator } from "../../domain/services/short-code-generation";
import { UrlRepository } from "../../ports/url-repository";

export class ShortenUrl {
  constructor(private repository: UrlRepository) {}

  async execute(originalUrl: string) {
    const code: string = ShortCodeGenerator.generate();
    const shortUrl: ShortUrl = new ShortUrl(originalUrl, code);
    await this.repository.save(shortUrl);

    return {
      shortUrl: `${process.env.BASE_URL}/${code}`,
    };
  }
}
