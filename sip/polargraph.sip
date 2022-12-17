/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Sergey Salnikov
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


// typedef QCPDataContainer<QCPGraphData> QCPGraphDataContainer;
// typedef QCPDataContainerIterator<QCPGraphData> QCPGraphDataContainerIterator;


class QCPPolarLegendItem : public QCPAbstractLegendItem
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  QCPPolarLegendItem(QCPLegend *parent, QCPPolarGraph *graph);

  // getters:
  QCPPolarGraph *polarGraph();

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual QSize minimumOuterSizeHint() const;

  // non-virtual methods:
  QPen getIconBorderPen() const;
  QColor getTextColor() const;
  QFont getFont() const;
};


class QCPPolarGraph : public QCPLayerable
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  enum LineStyle { lsNone        ///< data points are not connected with any lines (e.g. data only represented
                                 ///< with symbols according to the scatter style, see \ref setScatterStyle)
                   ,lsLine       ///< data points are connected by a straight line
                 };

  QCPPolarGraph(QCPPolarAxisAngular *keyAxis, QCPPolarAxisRadial *valueAxis) /Transfer/;
  virtual ~QCPPolarGraph();

  // getters:
  QString name() const;
  bool antialiasedFill() const;
  bool antialiasedScatters() const;
  QPen pen() const;
  QBrush brush() const;
  bool periodic() const;
  QCPPolarAxisAngular *keyAxis() const;
  QCPPolarAxisRadial *valueAxis() const;
  QCP::SelectionType selectable() const;
  bool selected() const;
  QCPDataSelection selection() const;
  QCPGraphDataContainer* data() const;
  %MethodCode
    sipRes = sipCpp->data().data();
  %End
  LineStyle lineStyle() const;
  QCPScatterStyle scatterStyle() const;

  // setters:
  void setName(const QString &name);
  void setAntialiasedFill(bool enabled);
  void setAntialiasedScatters(bool enabled);
  void setPen(const QPen &pen);
  void setBrush(const QBrush &brush);
  void setPeriodic(bool enabled);
  void setKeyAxis(QCPPolarAxisAngular *axis);
  void setValueAxis(QCPPolarAxisRadial *axis);
  Q_SLOT void setSelectable(QCP::SelectionType selectable);
  Q_SLOT void setSelection(QCPDataSelection selection);
  void setData(QCPGraphDataContainer *data);
  %MethodCode
    sipCpp->setData(QSharedPointer<QCPGraphDataContainer>(a0));
  %End
  void setData(const QVector<double> &keys, const QVector<double> &values, bool alreadySorted=false);
  void setLineStyle(LineStyle ls);
  void setScatterStyle(const QCPScatterStyle &style);

  // non-property methods:
  void addData(const QVector<double> &keys, const QVector<double> &values, bool alreadySorted=false);
  void addData(double key, double value);
  const QPointF coordsToPixels(double key, double value) const;
  void pixelsToCoords(double x, double y, double &key, double &value) const;
  void pixelsToCoords(const QPointF &pixelPos, double &key, double &value) const;
  void rescaleAxes(bool onlyEnlarge=false) const;
  void rescaleKeyAxis(bool onlyEnlarge=false) const;
  void rescaleValueAxis(bool onlyEnlarge=false, bool inKeyRange=false) const;
  bool addToLegend(QCPLegend *legend);
  bool addToLegend();
  bool removeFromLegend(QCPLegend *legend) const;
  bool removeFromLegend() const;

  // introduced virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const; // actually introduced in QCPLayerable as non-pure, but we want to force reimplementation for plottables
  virtual QCPPlottableInterface1D *interface1D(); // TODO: return this later, when QCPAbstractPolarPlottable is created
  virtual QCPRange getKeyRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth) const;
  virtual QCPRange getValueRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth, const QCPRange &inKeyRange=QCPRange()) const;

signals:
  void selectionChanged(bool selected);
  void selectionChanged(const QCPDataSelection &selection);
  void selectableChanged(QCP::SelectionType selectable);

protected:
  // introduced virtual methods (later reimplemented TODO from QCPAbstractPolarPlottable):
  virtual QRect clipRect() const;
  virtual void draw(QCPPainter *painter);
  virtual QCP::Interaction selectionCategory() const;
  void applyDefaultAntialiasingHint(QCPPainter *painter) const;
  // events:
  virtual void selectEvent(QMouseEvent *event, bool additive, const QVariant &details, bool *selectionStateChanged);
  virtual void deselectEvent(bool *selectionStateChanged);
  // virtual drawing helpers:
  virtual void drawLinePlot(QCPPainter *painter, const QVector<QPointF> &lines) const;
  virtual void drawFill(QCPPainter *painter, QVector<QPointF> *lines) const;
  virtual void drawScatterPlot(QCPPainter *painter, const QVector<QPointF> &scatters, const QCPScatterStyle &style) const;

  // introduced virtual methods:
  virtual void drawLegendIcon(QCPPainter *painter, const QRectF &rect) const;

  // non-virtual methods:
  void applyFillAntialiasingHint(QCPPainter *painter) const;
  void applyScattersAntialiasingHint(QCPPainter *painter) const;
//   double pointDistance(const QPointF &pixelPoint, QCPGraphDataContainer::const_iterator &closestData) const;
  // drawing helpers:
  virtual int dataCount() const;
  void getDataSegments(QList<QCPDataRange> &selectedSegments, QList<QCPDataRange> &unselectedSegments) const;
  void drawPolyline(QCPPainter *painter, const QVector<QPointF> &lineData) const;
//   void getVisibleDataBounds(QCPGraphDataContainer::const_iterator &begin, QCPGraphDataContainer::const_iterator &end, const QCPDataRange &rangeRestriction) const;
  void getLines(QVector<QPointF> *lines, const QCPDataRange &dataRange) const;
  void getScatters(QVector<QPointF> *scatters, const QCPDataRange &dataRange) const;
//   void getOptimizedLineData(QVector<QCPGraphData> *lineData, const QCPGraphDataContainer::const_iterator &begin, const QCPGraphDataContainer::const_iterator &end) const;
//   void getOptimizedScatterData(QVector<QCPGraphData> *scatterData, QCPGraphDataContainer::const_iterator begin, QCPGraphDataContainer::const_iterator end) const;
  QVector<QPointF> dataToLines(const QVector<QCPGraphData> &data) const;
};
