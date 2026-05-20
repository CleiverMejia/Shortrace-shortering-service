import { ShortUrl } from "../domain/entities/short-url";

export interface UrlRepository {
  save(url: ShortUrl): Promise<void>;
}
