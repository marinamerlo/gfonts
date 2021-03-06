
#' Setup a font to be used in Shiny or Markdown
#'
#' @param id Id of the font, correspond to column \code{id} from \code{\link{get_all_fonts}}.
#' @param output_dir Output directory where to save font and CSS files. Must be a directory.
#' @param variants Variant(s) to download, default is to includes all available ones.
#'
#' @return To directories will be created (if they do not exist): \strong{fonts} and \strong{css}.
#' @export
#'
#' @importFrom usethis ui_done ui_todo
#'
#' @examples
#' \donttest{
#'
#'
#' # In a Shiny app, you can use the www/ directory
#' # in Markdown, use a subfolder of your Rmd directory
#' setup_font(
#'   id = "open-sans-condensed",
#'   output_dir = "path/to/www"
#' )
#'
#' }
setup_font <- function(id, output_dir, variants = NULL) {

  output_dir <- normalizePath(path = output_dir, mustWork = TRUE)
  dir_info <- file.info(output_dir)
  if (isFALSE(dir_info$isdir))
    stop("setup_font: output_dir must be a directory!", call. = FALSE)

  font_dir <- file.path(output_dir, "fonts")
  if (!dir.exists(paths = font_dir))
    dir.create(path = font_dir)
  css_dir <- file.path(output_dir, "css")
  if (!dir.exists(paths = css_dir))
    dir.create(path = css_dir)

  download_font(
    id = id,
    output_dir = font_dir,
    variants = variants
  )
  usethis::ui_done("Font downloaded")

  generate_css(
    id = id,
    variants = variants,
    output = file.path(css_dir, paste0(id, ".css")),
    font_dir = "../fonts/"
  )
  usethis::ui_done("CSS generated")

  path_to_css <- file.path(basename(output_dir), "css", paste0(id, ".css"))
  usethis::ui_todo(
    "Please use `use_font(\"{id}\", \"{path_to_css}\")` to import the font in Shiny or Markdown."
  )
}





