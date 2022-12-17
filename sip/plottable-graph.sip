/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Sergey Salnikov
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPGraphData
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  QCPGraphData();
  QCPGraphData(double key, double value);

  double sortKey() const;
  static QCPGraphData fromSortKey(double sortKey);
  static bool sortKeyIsMainKey();

  double mainKey() const;
  double mainValue() const;

  QCPRange valueRange() const;

  double key;
  double value;
};


typedef QCPAbstractPlottable1D<QCPGraphData> QCPAbstractPlottable1D_QCPGraphData;
typedef QCPDataContainer<QCPGraphData> QCPGraphDataContainer;
typedef QCPDataContainerIterator<QCPGraphData> QCPGraphDataContainerIterator;


class QCPGraph : public QCPAbstractPlottable1D_QCPGraphData
{
%TypeHeaderCode
#include <qcustomplot.h>

typedef QCPAbstractPlottable1D<QCPGraphData> QCPAbstractPlottable1D_QCPGraphData;
%End
public:
  enum LineStyle { lsNone        ///< data points are not connected with any lines (e.g. data only represented
                                 ///< with symbols according to the scatter style, see \ref setScatterStyle)
                   ,lsLine       ///< data points are connected by a straight line
                   ,lsStepLeft   ///< line is drawn as steps where the step height is the value of the left data point
                   ,lsStepRight  ///< line is drawn as steps where the step height is the value of the right data point
                   ,lsStepCenter ///< line is drawn as steps where the step is in between two data points
                   ,lsImpulse    ///< each data point is represented by a line parallel to the value axis, which reaches from the data point to the zero-value-line
                 };

  explicit QCPGraph(QCPAxis *keyAxis, QCPAxis *valueAxis) /Transfer/;
  virtual ~QCPGraph();

  // getters:
  QCPGraphDataContainer *data() const;
  %MethodCode
    sipRes = sipCpp->data().data();
  %End
  LineStyle lineStyle() const;
  QCPScatterStyle scatterStyle() const;
  int scatterSkip() const;
  QCPGraph *channelFillGraph() const;
  bool adaptiveSampling() const;

  // setters:
  void setData(QCPGraphDataContainer *data);
  %MethodCode
    sipCpp->setData(QSharedPointer<QCPGraphDataContainer>(a0));
  %End
  void setData(const QVector<double> &keys, const QVector<double> &values, bool alreadySorted=false);
  void setLineStyle(LineStyle ls);
  void setScatterStyle(const QCPScatterStyle &style);
  void setScatterSkip(int skip);
  void setChannelFillGraph(QCPGraph *targetGraph);
  void setAdaptiveSampling(bool enabled);

  // non-property methods:
  void addData(const QVector<double> &keys, const QVector<double> &values, bool alreadySorted=false);
  void addData(double key, double value);

  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  virtual QCPRange getKeyRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth) const;
  virtual QCPRange getValueRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth, const QCPRange &inKeyRange=QCPRange()) const;

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual void drawLegendIcon(QCPPainter *painter, const QRectF &rect) const;

  // introduced virtual methods:
  virtual void drawFill(QCPPainter *painter, QVector<QPointF> *lines) const;
  virtual void drawScatterPlot(QCPPainter *painter, const QVector<QPointF> &scatters, const QCPScatterStyle &style) const;
  virtual void drawLinePlot(QCPPainter *painter, const QVector<QPointF> &lines) const;
  virtual void drawImpulsePlot(QCPPainter *painter, const QVector<QPointF> &lines) const;

//   TODO: iterators
//   virtual void getOptimizedLineData(QVector<QCPGraphData> *lineData, const QCPGraphDataContainer::const_iterator &begin, const QCPGraphDataContainer::const_iterator &end) const;
//   virtual void getOptimizedScatterData(QVector<QCPGraphData> *scatterData, QCPGraphDataContainer::const_iterator begin, QCPGraphDataContainer::const_iterator end) const;

  // non-virtual methods:
//   void getVisibleDataBounds(QCPGraphDataContainer::const_iterator &begin, QCPGraphDataContainer::const_iterator &end, const QCPDataRange &rangeRestriction) const;
  void getLines(QVector<QPointF> *lines, const QCPDataRange &dataRange) const;
  void getScatters(QVector<QPointF> *scatters, const QCPDataRange &dataRange) const;
  QVector<QPointF> dataToLines(const QVector<QCPGraphData> &data) const;
  QVector<QPointF> dataToStepLeftLines(const QVector<QCPGraphData> &data) const;
  QVector<QPointF> dataToStepRightLines(const QVector<QCPGraphData> &data) const;
  QVector<QPointF> dataToStepCenterLines(const QVector<QCPGraphData> &data) const;
  QVector<QPointF> dataToImpulseLines(const QVector<QCPGraphData> &data) const;
  QVector<QCPDataRange> getNonNanSegments(const QVector<QPointF> *lineData, Qt::Orientation keyOrientation) const;
//   TODO: unsupported function return type
//   QVector<QPair<QCPDataRange, QCPDataRange> > getOverlappingSegments(QVector<QCPDataRange> thisSegments, const QVector<QPointF> *thisData, QVector<QCPDataRange> otherSegments, const QVector<QPointF> *otherData) const;
  bool segmentsIntersect(double aLower, double aUpper, double bLower, double bUpper, int &bPrecedence) const;
  QPointF getFillBasePoint(QPointF matchingDataPoint) const;
  const QPolygonF getFillPolygon(const QVector<QPointF> *lineData, QCPDataRange segment) const;
  const QPolygonF getChannelFillPolygon(const QVector<QPointF> *thisData, QCPDataRange thisSegment, const QVector<QPointF> *otherData, QCPDataRange otherSegment) const;
  int findIndexBelowX(const QVector<QPointF> *data, double x) const;
  int findIndexAboveX(const QVector<QPointF> *data, double x) const;
  int findIndexBelowY(const QVector<QPointF> *data, double y) const;
  int findIndexAboveY(const QVector<QPointF> *data, double y) const;
//   double pointDistance(const QPointF &pixelPoint, QCPGraphDataContainer::const_iterator &closestData) const;
};
