import 'package:asmrapp/data/models/dlsite/dlsite_work_detail.dart';
import 'package:asmrapp/data/services/dlsite_service.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/presentation/viewmodels/dlsite_detail_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DlsiteDetailScreen extends StatelessWidget {
  final Uri pageUrl;

  const DlsiteDetailScreen({super.key, required this.pageUrl});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DlsiteDetailViewModel(
        pageUrl: pageUrl,
        service: GetIt.I<DlsiteService>(),
      )..load(),
      child: const _DlsiteDetailView(),
    );
  }
}

class _DlsiteDetailView extends StatelessWidget {
  const _DlsiteDetailView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DlsiteDetailViewModel>();
    final detail = viewModel.detail;
    final officialUrl = detail?.pageUrl ?? viewModel.pageUrl;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.dlsiteDetailsTitle),
        actions: [
          IconButton(
            tooltip: context.l10n.openDlsiteInBrowser,
            onPressed: () => _openExternalUrl(context, officialUrl),
            icon: const Icon(Icons.open_in_new),
          ),
          IconButton(
            tooltip: MaterialLocalizations.of(
              context,
            ).refreshIndicatorSemanticLabel,
            onPressed: viewModel.isLoading ? null : viewModel.reload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _buildBody(context, viewModel),
    );
  }

  Widget _buildBody(BuildContext context, DlsiteDetailViewModel viewModel) {
    if (viewModel.isLoading && viewModel.detail == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final detail = viewModel.detail;
    if (detail == null) {
      return _LoadError(
        error: viewModel.error,
        pageUrl: viewModel.pageUrl,
        onRetry: viewModel.reload,
      );
    }

    return RefreshIndicator(
      onRefresh: viewModel.reload,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 980),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (viewModel.isLoading) const LinearProgressIndicator(),
                  _WorkHeader(detail: detail),
                  const SizedBox(height: 12),
                  _SourceNotice(url: detail.pageUrl),
                  const SizedBox(height: 12),
                  _WorkInfoSection(detail: detail),
                  const SizedBox(height: 12),
                  _DescriptionSection(detail: detail),
                  const SizedBox(height: 12),
                  _RecommendationsSection(works: detail.recommendations),
                  const SizedBox(height: 12),
                  _ArticlesSection(articles: detail.relatedArticles),
                  const SizedBox(height: 12),
                  _ReviewsSection(
                    reviews: detail.reviews,
                    totalCount: detail.reviewCount,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadError extends StatelessWidget {
  final Object? error;
  final Uri pageUrl;
  final VoidCallback onRetry;

  const _LoadError({
    required this.error,
    required this.pageUrl,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_off_outlined, size: 56, color: colors.error),
              const SizedBox(height: 16),
              Text(
                context.l10n.dlsiteLoadFailed,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (error != null) ...[
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: [
                  FilledButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: Text(context.l10n.retry),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _openExternalUrl(context, pageUrl),
                    icon: const Icon(Icons.open_in_new),
                    label: Text(context.l10n.dlsiteOpenOfficial),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkHeader extends StatelessWidget {
  final DlsiteWorkDetail detail;

  const _WorkHeader({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 680;
          final cover = SizedBox(
            width: wide ? 320 : double.infinity,
            height: wide ? 320 : null,
            child: AspectRatio(
              aspectRatio: wide ? 1 : 4 / 3,
              child: _NetworkImage(url: detail.imageUrl),
            ),
          );
          final info = Padding(
            padding: const EdgeInsets.all(20),
            child: _HeaderInfo(detail: detail),
          );
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                cover,
                Expanded(child: info),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [cover, info],
          );
        },
      ),
    );
  }
}

class _HeaderInfo extends StatelessWidget {
  final DlsiteWorkDetail detail;

  const _HeaderInfo({required this.detail});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          detail.productId,
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        SelectableText(
          detail.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (detail.circleName != null) ...[
          const SizedBox(height: 8),
          InkWell(
            onTap: detail.circleUrl == null
                ? null
                : () => _openExternalUrl(context, detail.circleUrl!),
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.storefront_outlined, size: 18),
                  const SizedBox(width: 6),
                  Flexible(child: Text(detail.circleName!)),
                  if (detail.circleUrl != null) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.open_in_new, size: 14),
                  ],
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 14),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (detail.price != null)
              Text(
                '¥${NumberFormat.decimalPattern(locale).format(detail.price)}',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            if (detail.rating != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber, size: 22),
                  const SizedBox(width: 3),
                  Text(
                    detail.rating!.toStringAsFixed(2),
                    style: theme.textTheme.titleMedium,
                  ),
                  if (detail.ratingCount != null)
                    Text(
                      ' (${NumberFormat.decimalPattern(locale).format(detail.ratingCount)})',
                    ),
                ],
              ),
          ],
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => _openExternalUrl(context, detail.pageUrl),
            icon: const Icon(Icons.open_in_new),
            label: Text(context.l10n.dlsiteOpenOfficial),
          ),
        ),
      ],
    );
  }
}

class _SourceNotice extends StatelessWidget {
  final Uri url;

  const _SourceNotice({required this.url});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _openExternalUrl(context, url),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: colors.onSecondaryContainer),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  context.l10n.dlsiteSourceNotice,
                  style: TextStyle(color: colors.onSecondaryContainer),
                ),
              ),
              Icon(
                Icons.open_in_new,
                size: 18,
                color: colors.onSecondaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkInfoSection extends StatelessWidget {
  final DlsiteWorkDetail detail;

  const _WorkInfoSection({required this.detail});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.l10n.dlsiteWorkInfo,
      icon: Icons.info_outline,
      child: detail.workInfo.isEmpty
          ? const _EmptySection()
          : Column(
              children: [
                for (
                  var index = 0;
                  index < detail.workInfo.length;
                  index++
                ) ...[
                  if (index > 0) const Divider(height: 1),
                  _WorkInfoRow(item: detail.workInfo[index]),
                ],
              ],
            ),
    );
  }
}

class _WorkInfoRow extends StatelessWidget {
  final DlsiteWorkInfo item;

  const _WorkInfoRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.url == null
          ? null
          : () => _openExternalUrl(context, item.url!),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 92,
              child: Text(
                item.label,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(item.value)),
            if (item.url != null) ...[
              const SizedBox(width: 8),
              const Icon(Icons.open_in_new, size: 16),
            ],
          ],
        ),
      ),
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  final DlsiteWorkDetail detail;

  const _DescriptionSection({required this.detail});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.l10n.dlsiteDescription,
      icon: Icons.subject,
      child: detail.descriptionSections.isEmpty
          ? const _EmptySection()
          : Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (
                    var index = 0;
                    index < detail.descriptionSections.length;
                    index++
                  ) ...[
                    if (index > 0) const Divider(height: 32),
                    _DescriptionPart(
                      section: detail.descriptionSections[index],
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}

class _DescriptionPart extends StatelessWidget {
  final DlsiteDescriptionSection section;

  const _DescriptionPart({required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section.heading != null) ...[
          Text(
            section.heading!,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
        ],
        for (var index = 0; index < section.blocks.length; index++) ...[
          if (index > 0) const SizedBox(height: 14),
          switch (section.blocks[index]) {
            DlsiteDescriptionTextBlock block => SelectableText(block.text),
            DlsiteDescriptionImageBlock block => _DescriptionImage(
              block: block,
            ),
          },
        ],
        if (section.links.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: section.links
                .map(
                  (link) => ActionChip(
                    avatar: const Icon(Icons.open_in_new, size: 16),
                    label: Text(link.label),
                    onPressed: () => _openExternalUrl(context, link.url),
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }
}

class _DescriptionImage extends StatelessWidget {
  final DlsiteDescriptionImageBlock block;

  const _DescriptionImage({required this.block});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final targetUrl = block.linkUrl ?? block.imageUrl;
    final placeholder = AspectRatio(
      aspectRatio: block.aspectRatio ?? 4 / 3,
      child: ColoredBox(
        color: theme.colorScheme.surfaceContainerHighest,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
    final error = AspectRatio(
      aspectRatio: block.aspectRatio ?? 4 / 3,
      child: ColoredBox(
        color: theme.colorScheme.surfaceContainerHighest,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.broken_image_outlined,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(height: 8),
              Text(
                context.l10n.dlsiteImageLoadFailed,
                style: TextStyle(color: theme.colorScheme.outline),
              ),
            ],
          ),
        ),
      ),
    );

    return Semantics(
      button: true,
      image: true,
      label: block.alt ?? context.l10n.dlsiteBodyImage,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: theme.colorScheme.surfaceContainerHighest,
          child: InkWell(
            onTap: () => _openExternalUrl(context, targetUrl),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: block.imageUrl.toString(),
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  placeholder: (_, _) => placeholder,
                  errorWidget: (_, _, _) => error,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withValues(alpha: 0.84),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Icon(
                        Icons.open_in_new,
                        size: 18,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecommendationsSection extends StatelessWidget {
  final List<DlsiteRecommendation> works;

  const _RecommendationsSection({required this.works});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.l10n.dlsiteRecommendations,
      icon: Icons.recommend_outlined,
      child: works.isEmpty
          ? const _EmptySection()
          : SizedBox(
              height: 360,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
                scrollDirection: Axis.horizontal,
                itemCount: works.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) =>
                    _RecommendationCard(work: works[index]),
              ),
            ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final DlsiteRecommendation work;

  const _RecommendationCard({required this.work});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 178,
      child: Card(
        color: theme.colorScheme.surfaceContainerLow,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _openExternalUrl(context, work.url),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 158,
                child: _NetworkImage(url: work.imageUrl),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (work.category != null)
                        Text(
                          work.category!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      const SizedBox(height: 3),
                      Text(
                        work.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      if (work.makerName != null)
                        Text(
                          work.makerName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                      if (work.priceLabel != null)
                        Text(
                          work.priceLabel!,
                          maxLines: 1,
                          style: theme.textTheme.labelLarge,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticlesSection extends StatelessWidget {
  final List<DlsiteArticle> articles;

  const _ArticlesSection({required this.articles});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.l10n.dlsiteRelatedArticles,
      icon: Icons.article_outlined,
      child: articles.isEmpty
          ? const _EmptySection()
          : SizedBox(
              height: 224,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
                scrollDirection: Axis.horizontal,
                itemCount: articles.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) =>
                    _ArticleCard(article: articles[index]),
              ),
            ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final DlsiteArticle article;

  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _openExternalUrl(context, article.url),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 130,
                width: double.infinity,
                child: _NetworkImage(url: article.imageUrl),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          article.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.open_in_new, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewsSection extends StatelessWidget {
  final List<DlsiteReview> reviews;
  final int totalCount;

  const _ReviewsSection({required this.reviews, required this.totalCount});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: context.l10n.dlsiteReviews,
      subtitle: totalCount > 0
          ? context.l10n.dlsiteReviewsCount(totalCount)
          : null,
      icon: Icons.rate_review_outlined,
      child: reviews.isEmpty
          ? const _EmptySection()
          : Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
              child: Column(
                children: [
                  for (var index = 0; index < reviews.length; index++) ...[
                    if (index > 0) const SizedBox(height: 10),
                    _ReviewCard(review: reviews[index]),
                  ],
                ],
              ),
            ),
    );
  }
}

class _ReviewCard extends StatefulWidget {
  final DlsiteReview review;

  const _ReviewCard({required this.review});

  @override
  State<_ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<_ReviewCard> {
  bool _spoilerVisible = false;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final review = widget.review;
    final theme = Theme.of(context);
    final hideSpoiler = review.containsSpoilers && !_spoilerVisible;
    final canExpand = review.text.length > 120;

    return Card(
      color: theme.colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (review.rating != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 1),
                    child: _RatingStars(rating: review.rating!),
                  ),
                Expanded(
                  child: Text(
                    review.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: context.l10n.openDlsiteInBrowser,
                  onPressed: () => _openExternalUrl(context, review.url),
                  icon: const Icon(Icons.open_in_new, size: 19),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (review.author != null)
                  Text(review.author!, style: theme.textTheme.bodySmall),
                if (review.date != null)
                  Text(
                    review.date!.split(' ').first,
                    style: theme.textTheme.bodySmall,
                  ),
                if (review.isPurchased)
                  _SmallBadge(
                    icon: Icons.verified_outlined,
                    label: context.l10n.dlsitePurchased,
                  ),
                if (review.helpfulCount > 0)
                  _SmallBadge(
                    icon: Icons.thumb_up_alt_outlined,
                    label: context.l10n.dlsiteHelpfulCount(review.helpfulCount),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (hideSpoiler)
              DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 6, 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.visibility_off_outlined,
                        size: 19,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          context.l10n.dlsiteContainsSpoilers,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: theme.colorScheme.primary,
                          minimumSize: const Size(0, 40),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          visualDensity: VisualDensity.compact,
                        ),
                        onPressed: () => setState(() => _spoilerVisible = true),
                        child: Text(context.l10n.dlsiteShowSpoiler),
                      ),
                    ],
                  ),
                ),
              )
            else ...[
              Text(
                review.text,
                maxLines: _expanded ? null : 7,
                overflow: _expanded ? null : TextOverflow.ellipsis,
              ),
              if (canExpand)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => setState(() => _expanded = !_expanded),
                    child: Text(
                      _expanded
                          ? context.l10n.dlsiteShowLess
                          : context.l10n.dlsiteShowMore,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RatingStars extends StatelessWidget {
  final int rating;

  const _RatingStars({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star_rounded : Icons.star_border_rounded,
          size: 17,
          color: Colors.amber.shade700,
        ),
      ),
    );
  }
}

class _SmallBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SmallBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: colors.onPrimaryContainer),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colors.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 12),
            child: Row(
              children: [
                Icon(icon, color: theme.colorScheme.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (subtitle != null)
                  Text(subtitle!, style: theme.textTheme.labelMedium),
              ],
            ),
          ),
          const Divider(height: 1),
          child,
        ],
      ),
    );
  }
}

class _EmptySection extends StatelessWidget {
  const _EmptySection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              context.l10n.dlsiteNoContent,
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
          ),
        ],
      ),
    );
  }
}

class _NetworkImage extends StatelessWidget {
  final Uri? url;

  const _NetworkImage({required this.url});

  @override
  Widget build(BuildContext context) {
    final fallback = ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
    if (url == null) return fallback;
    return CachedNetworkImage(
      imageUrl: url.toString(),
      fit: BoxFit.cover,
      placeholder: (_, _) => ColoredBox(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: const Center(child: CircularProgressIndicator()),
      ),
      errorWidget: (_, _, _) => fallback,
    );
  }
}

Future<void> _openExternalUrl(BuildContext context, Uri url) async {
  var opened = false;
  try {
    opened = await launchUrl(url, mode: LaunchMode.externalApplication);
  } catch (_) {
    opened = false;
  }
  if (!opened && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.operationFailed(url.toString()))),
    );
  }
}
