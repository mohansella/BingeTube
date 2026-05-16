import discoverData from "../../public/discover/discover.json";

export interface SeriesModel {
  title: string;
  description: string;
  coverId: string;
  coverUrl: string;
  iconUrl: string;
  totalVideos: number;
  dataPath: string;
  dataHash: string;
}

export interface DiscoverCollection {
  name: string;
  series: string[];
}

export interface DiscoverData {
  collections: DiscoverCollection[];
  top_picks: string[];
  models: Record<string, SeriesModel>;
}

export interface CollectionViewModel {
  name: string;
  slug: string;
  description: string;
  seoTitle: string;
  seoDescription: string;
  editorialNote: string;
  series: Array<SeriesModel & { id: string }>;
  totalVideos: number;
}

const discover = discoverData as DiscoverData;

const collectionContent: Record<
  string,
  { description: string; seoTitle: string; seoDescription: string; editorialNote: string }
> = {
  "action-adventure": {
    description:
      "High-energy web originals, cinematic fan films, and animated battles with enough momentum to carry a full night of watching.",
    seoTitle: "Action & Adventure YouTube Series Collection | BingeTube",
    seoDescription:
      "Watch action web series, fan films, and animated adventure series in curated BingeTube order without repeat videos.",
    editorialNote:
      "This collection is built for momentum: start with punchy modern originals, move through animated spectacle, and keep the shorter fan-film runs close enough to finish in one sitting.",
  },
  "sci-fi-originals": {
    description:
      "Serialized future worlds, strange technology, and speculative stories organized for a focused science-fiction binge.",
    seoTitle: "Sci-Fi Originals YouTube Series Collection | BingeTube",
    seoDescription:
      "Explore sci-fi web series and futuristic YouTube originals grouped into a focused collection for sequential viewing.",
    editorialNote:
      "The picks lean toward complete arcs and clear premises, so the page works as a sci-fi shelf instead of a pile of disconnected trailers and one-off clips.",
  },
  "horror-mystery": {
    description:
      "Found footage, analog horror, supernatural stories, and mystery-driven series for viewers who like tension with structure.",
    seoTitle: "Horror & Mystery YouTube Series Collection | BingeTube",
    seoDescription:
      "Browse horror, mystery, analog horror, and found-footage YouTube series arranged for structured binge watching.",
    editorialNote:
      "Horror is especially sensitive to order. These series are grouped so reveals, mythology, and recurring clues stay easier to follow.",
  },
  "comedy-web-originals": {
    description:
      "Sketches, sitcoms, satire, and character-driven web shows collected into a cleaner comedy queue.",
    seoTitle: "Comedy & Web Originals YouTube Collection | BingeTube",
    seoDescription:
      "Find comedy sketches, sitcom-style YouTube originals, and web comedy series collected for repeat-free watching.",
    editorialNote:
      "Comedy gets messy when platforms replay only the biggest clips. This page favors complete runs and shows with enough variety to keep the queue fresh.",
  },
  "animation-family": {
    description:
      "Visual comedy, cartoons, and family-friendly animation that works especially well when watched without repeat loops.",
    seoTitle: "Animation & Family YouTube Series Collection | BingeTube",
    seoDescription:
      "Browse family-friendly animation and cartoon series on YouTube, organized into a cleaner BingeTube collection.",
    editorialNote:
      "These are easy to rewatch, but the goal here is to stop the same few episodes from looping forever and give the collection a steadier flow.",
  },
  "design-creativity": {
    description:
      "Design, filmmaking, branding, and game craft series for creative people who want inspiration without the recommendation churn.",
    seoTitle: "Design & Creativity YouTube Series Collection | BingeTube",
    seoDescription:
      "Discover design, branding, filmmaking, visual effects, and game design YouTube series curated by BingeTube.",
    editorialNote:
      "The collection moves across creative disciplines, from brand systems and product design to games and visual effects, while keeping each series intact.",
  },
  "science-technology": {
    description:
      "Science, AI, space, computer science, and slow-motion experiments arranged as watchable learning paths.",
    seoTitle: "Science & Technology YouTube Series Collection | BingeTube",
    seoDescription:
      "Watch science, AI, space, computer science, and technology YouTube series in curated sequential order.",
    editorialNote:
      "These series are grouped for curious watching: ideas, experiments, and explanations that benefit from continuity instead of random autoplay.",
  },
  "nature-documentary": {
    description:
      "Nature, wildlife, and documentary series with a calmer pace and enough depth for longer viewing sessions.",
    seoTitle: "Nature & Documentary YouTube Collection | BingeTube",
    seoDescription:
      "Browse nature documentary and wildlife YouTube series organized into a calm, sequential BingeTube collection.",
    editorialNote:
      "This page keeps the documentary material together so the viewing experience feels closer to a themed shelf than a scattered search result.",
  },
  "retro-tech-machines": {
    description:
      "Classic technology, machines, aviation, and computing history for anyone who likes seeing how modern tools came to be.",
    seoTitle: "Retro Tech & Machines YouTube Collection | BingeTube",
    seoDescription:
      "Explore retro technology, computing history, machines, and aviation documentary series collected by BingeTube.",
    editorialNote:
      "The collection is part nostalgia and part engineering history, with older documentary runs sitting next to modern retro-tech explainers.",
  },
};

export function slugify(input: string) {
  return input
    .toLowerCase()
    .replace(/[^\w\s-]/g, "")
    .replace(/\s+/g, "-")
    .replace(/-+/g, "-")
    .trim();
}

export function getCollectionUrl(collection: Pick<CollectionViewModel, "slug">) {
  return `/collections/${collection.slug}/`;
}

export function getAppSeriesUrl(id: string) {
  return `/app/series/${id}`;
}

export function getCollections(): CollectionViewModel[] {
  return discover.collections.map((collection) => {
    const slug = slugify(collection.name);
    const series = collection.series.map((id) => {
      const model = discover.models[`${id}.binge`];
      if (!model) {
        throw new Error(`Missing discover model for ${id}.binge`);
      }
      return { ...model, id };
    });

    return {
      name: collection.name,
      slug,
      description: collectionContent[slug]?.description ?? defaultCollectionDescription(series),
      seoTitle:
        collectionContent[slug]?.seoTitle ??
        `${collection.name} YouTube Series Collection | BingeTube`,
      seoDescription:
        collectionContent[slug]?.seoDescription ??
        defaultCollectionDescription(series),
      editorialNote:
        collectionContent[slug]?.editorialNote ??
        "This collection is grouped to make longer YouTube watching sessions easier to start, follow, and finish.",
      series,
      totalVideos: series.reduce((total, item) => total + item.totalVideos, 0),
    };
  });
}

export function getTopPicks() {
  return discover.top_picks.map((id) => {
    const model = discover.models[`${id}.binge`];
    if (!model) {
      throw new Error(`Missing top pick model for ${id}.binge`);
    }
    return { ...model, id };
  });
}

function defaultCollectionDescription(series: SeriesModel[]) {
  const names = series.slice(0, 3).map((item) => item.title).join(", ");
  return `A curated BingeTube collection featuring ${names} and more, organized for sequential watching.`;
}
