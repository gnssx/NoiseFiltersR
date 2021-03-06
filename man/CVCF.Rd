% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CVCF.R
\name{CVCF}
\alias{CVCF}
\alias{CVCF.default}
\alias{CVCF.formula}
\title{Cross-Validated Committees Filter}
\usage{
\method{CVCF}{formula}(formula, data, ...)

\method{CVCF}{default}(x, nfolds = 10, consensus = FALSE,
  classColumn = ncol(x), ...)
}
\arguments{
\item{formula}{A formula describing the classification variable and the attributes to be used.}

\item{data, x}{data frame containing the tranining dataset to be filtered.}

\item{...}{Optional parameters to be passed to other methods.}

\item{nfolds}{number of folds in which the dataset is split.}

\item{consensus}{logical. If TRUE, consensus voting scheme is used. If
FALSE, majority voting scheme is applied.}

\item{classColumn}{positive integer indicating the column which contains the
(factor of) classes. By default, the last column is considered.}
}
\value{
An object of class \code{filter}, which is a list with seven components:
\itemize{
   \item \code{cleanData} is a data frame containing the filtered dataset.
   \item \code{remIdx} is a vector of integers indicating the indexes for
   removed instances (i.e. their row number with respect to the original data frame).
   \item \code{repIdx} is a vector of integers indicating the indexes for
   repaired/relabelled instances (i.e. their row number with respect to the original data frame).
   \item \code{repLab} is a factor containing the new labels for repaired instances.
   \item \code{parameters} is a list containing the argument values.
   \item \code{call} contains the original call to the filter.
   \item \code{extraInf} is a character that includes additional interesting
   information not covered by previous items.
}
}
\description{
Ensemble-based filter for removing label noise from a dataset as a
preprocessing step of classification. For more information, see 'Details' and
'References' sections.
}
\details{
Full description of the method can be looked up in the provided references.
Dataset is split in \code{nfolds} folds, a base classifiers (C4.5 in this implementation) is
built over every combination of \code{nfolds}-1 folds, and then tested on the whole dataset. Finally, consensus
or majority voting scheme is applied to remove noisy instances.
}
\examples{
# Next example is not run in order to save time
\dontrun{
data(iris)
# We fix a seed since there exists a random partition for the ensemble
set.seed(1)
out <- CVCF(Species~.-Sepal.Width, data = iris)
print(out)
identical(out$cleanData, iris[setdiff(1:nrow(iris),out$remIdx),])
}
}
\references{
Verbaeten S., Van Assche A. (2003, June): Ensemble methods for noise elimination in classification
problems. \emph{Proc. 4th Int. Conf. Multiple Classifier Syst.}, Guildford, U.K., pp. 317-325.
}

